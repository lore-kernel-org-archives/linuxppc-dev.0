From: tom_gall@vnet.ibm.com
Message-ID: <397F60D4.E5A417E6@vnet.ibm.com>
Date: Wed, 26 Jul 2000 22:06:12 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: modprobe and exec format error
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  Here's a strange one...

  I'm bringing up a 2.4.0-testX kernel (Paul's latest PMac tree) and the kernel
does come up quite a ways (tho how far is a bit hard to tell as things scroll by
and scroll lock doesn't work)

I get the following repeated item on my screen ... so imagine this line times N

/sbin/modprobe -s -k binfmt_4c46 errno=8

Well errno 8 is Exec format error as I recall...    time to upgrade modutils?

Anyone with any suggestions or have seen this one before?

Thanks in advance!

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
