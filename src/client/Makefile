TDIR = test/suite
SDIR = ../test/samples
CFGDIR = ../test/cfg
SMOKEDIR = ./test/smoke
COMDIR = ../test/common

tests = $(TDIR)/tparser \
        $(TDIR)/tframe 

SUTDIR = Network/Mom/Stompl

CLIENT = Client

SUBSRC = $(SUTDIR)/Client/Socket.hs \
         $(SUTDIR)/Client/Protocol.hs \
         $(SUTDIR)/Client/Factory.hs \
         $(SUTDIR)/Client/State.hs \
         $(SUTDIR)/Client/Queue.hs \
         $(SUTDIR)/Client/Streams.hs \
         $(SUTDIR)/Client/Basic.hs 

GHC = ghc
FLGS = -DTEST -Wall --make
INC  = -i./test/src -i./Network/Mom/Stompl/Client \
		    -i../broker/Network/Mom/Stompl \
		    -i../stompl/Network/Mom/Stompl \
		    -i../test/common

smoke:	$(SMOKEDIR)/listen2 \
        $(SMOKEDIR)/send2 \
        $(SMOKEDIR)/sendtx \
        $(SMOKEDIR)/sendf \
        $(SMOKEDIR)/sendforever \
        $(SMOKEDIR)/sendjp \
        $(SMOKEDIR)/frost \
        $(SMOKEDIR)/ping \
        $(SMOKEDIR)/demo1

$(SMOKEDIR)/listen2:	$(SMOKEDIR)/listen2.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/send2:	$(SMOKEDIR)/send2.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/frost:	$(SMOKEDIR)/frost.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/sendtx:	$(SMOKEDIR)/sendtx.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/sendf:	$(SMOKEDIR)/sendf.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/sendjp:	$(SMOKEDIR)/sendjp.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/sendforever:	$(SMOKEDIR)/sendforever.hs $(SUBSRC)
				$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/ping:	$(SMOKEDIR)/ping.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/demo1:	$(SMOKEDIR)/demo1.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/conduit1:	$(SMOKEDIR)/conduit1.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/cl1:	$(SMOKEDIR)/cl1.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(SMOKEDIR)/contx1:	$(SMOKEDIR)/contx1.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

suite:	$(TDIR)/tprotocol \
	$(TDIR)/tstate    \
	$(TDIR)/responder \
        $(TDIR)/tdialogs

run:	$(suite)
	$(TDIR)/responder &
	$(TDIR)/tprotocol
	$(TDIR)/tstate
	$(TDIR)/tdialogs 61613

$(TDIR)/responder:	$(TDIR)/responder.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(TDIR)/tprotocol:	$(TDIR)/tprotocol.hs $(TDIR)/responder $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(TDIR)/tprotocoldbg:	$(TDIR)/tprotocol.hs $(SUBSRC)
			$(GHC) $(FLGS) -D_DEBUG -o $@ $(INC) $(TDIR)/tprotocol.hs

$(TDIR)/tdialogs:	$(TDIR)/tdialogs.hs $(TDIR)/responder $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

$(TDIR)/tdialogsdbg:	$(TDIR)/tdialogs.hs $(SUBSRC)
			$(GHC) -o $@ $(FLGS) -D_DEBUG $(INC) $(TDIR)/tdialogs.hs

$(TDIR)/tstate:		$(TDIR)/tstate.hs $(SUBSRC)
			$(GHC) $(FLGS) $(INC) $@

clean:
	rm -f $(TDIR)/*.hi
	rm -f $(TDIR)/*.o
	rm -f $(TDIR)/tdialogs
	rm -f $(TDIR)/tdialogsdbg
	rm -f $(TDIR)/responder
	rm -f $(TDIR)/tprotocol
	rm -f $(TDIR)/tprotocoldbg
	rm -f $(TDIR)/tstate
	rm -f $(SMOKEDIR)/listen2
	rm -f $(SMOKEDIR)/send2
	rm -f $(SMOKEDIR)/sendtx
	rm -f $(SMOKEDIR)/sendf
	rm -f $(SMOKEDIR)/sendjp
	rm -f $(SMOKEDIR)/sendforever
	rm -f $(SMOKEDIR)/ping
	rm -f $(SMOKEDIR)/demo1
	rm -f $(SMOKEDIR)/frost
	rm -f $(SMOKEDIR)/cl1
	rm -f $(SMOKEDIR)/conduit1
	rm -f $(SMOKEDIR)/contx1
	rm -f $(SMOKEDIR)/*.hi
	rm -f $(SMOKEDIR)/*.o

dist-clean:	clean
		cabal clean
		rm -f $(SUTDIR)/Client/*.hi
		rm -f $(SUTDIR)/Client/*.o
		rm -f test/bin/*.o
		rm -f test/bin/*.hi

build: $(tests) $(SUBSRC)
