Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s10.bay0.hotmail.com (bay0-omc2-s10.bay0.hotmail.com
	[65.54.246.146]) by ozlabs.org (Postfix) with ESMTP id E2706DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 02:06:23 +1000 (EST)
Message-ID: <BAY115-W12CE664522EEB409218C3FB2350@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: ML403 2.6 kernel, root file system on NFS, stops after freeing
	unused kernel memory
Date: Wed, 23 May 2007 16:06:21 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all

I have studied the disscussion here mainly by Mirek32 (I think this was the=
 name)  but unfortunately the disscussion is finished without any suitable =
answer and solution.

the 2.6 kernel comes up on ml403 with no problem, it gets an IP address fro=
m my DHCP and mounts the root file system from my NFS server , all of these=
 are ok.=20

Unfortunately , after "freeing unused kernel memory ", init , console stops=
 working however the board is alive because it answers all of my pings corr=
ectly. I tried to make a telnet connection to the board with no success. ( =
I'm using ELDK 4.0)=20

any suggestions what is happening here?

how can I enable the telnet server so that I can make a telnet connection t=
o the board, As I said the board is alive and answers pings but does not pr=
int any thing on the screen.

thanks.
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQBR=
E=
