Date: Fri, 19 Nov 1999 20:58:19 -0500
From: Eric Dorland <dorland@lords.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Floppy problems
Message-ID: <19991119205819.A676@HSE-MTL-ppp4368.qc.sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
There seems to be a problem with the SWIM3 controller on my PowerMac G3.
Whenever I try to do any floppy realted operation (mount, dd, whatever) it
gives me this error:

end_request: I/O error, dev 02:00 (floppy), sector 36

does anyone know what this means or has had similar problems?

I'm running R5 on a a kernel I compiled myself, but not with anything
outrageous, just a few patches. I've got a G3/266, and I'm running linux off
a internal scsi drive.

Eric Dorland
dorland@lords.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
