Subject: Linux 2.4.24 on PQ2FADS
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFBAA77BB.483BA1A8-ONC1256E52.00468D91@uk.marconicomms.com>
From: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Tue, 9 Mar 2004 13:53:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear colleagues,

I'm trying to have Linux 2.4.24 working on my evaluation board PQ2FADS-VR
with ppc8275, but I'm suffering of a lot of instability problems.
The Boot-loader I use is Uboot-1.0.0 witch initialise correctly the board
at speed 66,133,199 and correctly fills bd_info struct.
But when I issue the command "=> bootm 100000" I observe every time a
different behaviour: sometimes I don't see anything, sometimes the board
stops in "Calibrating delay loop", sometimes after having written the line:

Memory: 30936k available (984k kernel code, 344k data, 52k init, 0k
highmem)

Or the line

POSIX conformance testing by UNIFIX

Only occasionally it reaches the init program (stopping here).

The same behaviour I observed with the images delivered by the Arabella
distribution!

Do you have any suggestion? MMU? Cache? Hardware?

Thanks in advance for your advice.

With best regards,

Stefano


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
