Message-ID: <D73A25AA6E54D511AD74009027B1110F3C066D@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Phillip.Treddenick@colorado.edu'" <Phillip.Treddenick@colorado.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Hung kernel on EP405?
Date: Mon, 17 Feb 2003 09:19:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have used the http://ppc.bkbits.net:8080/linuxppc_2_4_devel tree on the
ep405.  I have a .config file if you would like it.

-----Original Message-----
From: Phillip.Treddenick@colorado.edu
[mailto:Phillip.Treddenick@colorado.edu]
Sent: Sunday, February 16, 2003 2:38 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Hung kernel on EP405?



I am having trouble running Monta Vista Hardhat Linux on an EP405 board with
Solaris 2.7 as the host.  I'm using the Planetcore bootloader to download
the
kernel to the board, but when I run the kernel it appears to hang.  I would
like
to know if there is a way to verify what it's doing?  I've tried rlogin and
I've
tried pinging it, but I don't get any response.  The kernel is setup to
mount a
NFS, but I don't know how to verify that that is working either.  I tried
enabling the ethernet port by setting the board control and status
registers.
That didn't seem to work.  Do these registers have specific settings
necessary
for running the EP405 board?

Any help or insight is appreciated.
Thanks, Phill Treddenick
        treddeni@colorado.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
