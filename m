Message-ID: <3D462E36.7070803@dslextreme.com>
Date: Mon, 29 Jul 2002 23:12:06 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Changes to "The plan"
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is an addition to Paulus' plan back in November regarding
/platforms restructure with a change for 4xx I am thinking of for 2.5
  "http://lists.linuxppc.org/linuxppc-dev/200111/msg00083.html"


Paulus' plan mentioned a possibility of adding subdirectories within
/platforms if the number of files for a given platform was large enough
and I think 4xx qualifies.  I have a local copy working with a
/platforms/4xx structure were I moved 49 files to.  I am not sure if
this was the intent of "The plan" or not but it does make things look
cleaner.

Since I was in the mode of cleaning house I moved most of the 4xx config
options to /platforms/4xx/Config.in and have arch/ppc/config.in source it.

Also I think there  may a few other files that may need to move to/from
platforms/4xx to/from /kernel such as ibm405.h or ibm_ocp.h

so platforms/4xx looks like this:

Config.in
Makefile
ash.c
ash.h
beech.c
beech.h
ceder.c
ceder.h
cpci405.c
cpci405.h
ebony.c
ebony.h
ep405.c
ep405.h
ibm405.h
ibm405gp.c
ibm405gp.h
ibm405lp.c
ibm405lp.h
ibm440gp.c
ibm440gp.h
ibm_ocp.h
ibmnp405h.c
ibmnp405h.h
ibmnp405l.c
ibmnp405l.h
ibmnp4gs.c
ibmnp4gs.h
ibmstb3.c
ibmstb3.h
ibmstb4.c
ibmstb4.h
ibmstbx25.c
ibmstbx25.h
oak.h
oak_setup.c
oak_setup.h
rainier.c
rainier.h
redwood.c
redwood.h
redwood5.c
redwood5.h
redwood6.c
redwood6.h
walnut.c
walnut.h
xilinx_ml300.c
xilinx_ml300.h
xilinx_ocp/ -> 19 files
xilinx_ocp.h

comments, feedback or suggestions

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
