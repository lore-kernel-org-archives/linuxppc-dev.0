Message-ID: <67505026E29DD311A9AA00508B7315F350A569@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: HDLC/PPP Driver
Date: Fri, 20 Oct 2000 15:54:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
Thank you for the white paper.
My problem is my hdlcppp is confused with enet. It appears my enet is
calling the xmit in hdlcppp after the enet open is called. Weird. How could
this happen? My enet is on SCC1 and hdlcppp is SCC2. Could some parameter in
hdlcppp have priority even when enet is loaded?
Thank you for your help. I hope this is not to elementary.
--Julia


http://qslinux.org/docs/snmc/hdlc/index.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
