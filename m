Date: Thu, 20 May 1999 18:48:19 -0500 (CDT)
From: Derek Moeller <moeller@networksplus.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Diald Compilation problems
Message-ID: <Pine.LNX.3.96.990520183808.529A-100000@ns1.networksplus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I've been having problems compiling the Diald package for
LinuxPPC/4.1/iMac. Make gives up after complaining about many different
errors.  Unfortunately, there is no precompiled rpm avaible that I have
seen. Has anyone had success compiling this package, or is there a
different one that accomplishes similar? 
	BTW, during make depend it gives me a few warnings.

cc -E -M *.c > .depend
firewall.c:51: warning: `#ifdef' argument starts with a digit
firewall.c:58: warning: `#ifdef' argument starts with a digit
firewall.c:547: warning: `#ifdef' argument starts with a digit
firewall.c:579: warning: `#ifdef' argument starts with a digit
firewall.c:598: warning: `#ifdef' argument starts with a digit
ppp.c:11: warning: `#ifdef' argument starts with a digit
	
	The #ifdef's mentioned to have a digit (0) right after the
argument. I don't know why it's choking on this, though.
	Thanks...

--

+--------------------------------------+
 Derek Moeller moeller@networksplus.net 
     Linux for PowerPC User, Student    
   http://www.networksplus.net/moeller	 
    "aut inveniam viam aut faciam"	 
+--------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
