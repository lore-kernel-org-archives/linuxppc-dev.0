Message-Id: <200306121119.h5CBJsq32189@p2.parker.boston.ma.us>
To: Zhang Qiang MT-CN <Qiang.Zhang@mt.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	brad@p2.parker.boston.ma.us
Subject: Re: smbclient on my MPC823 board 
In-Reply-To: Message from Zhang Qiang MT-CN <Qiang.Zhang@mt.com>
   of "Tue, 10 Jun 2003 17:01:56 +0800." <299848370240D611A24400B0D079FBEB91CFDB@smtcn3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jun 2003 07:19:54 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a one line fix - you need to specify

samba_cv_HAVE_IFACE_IFCONF=yes export samba_cv_HAVE_IFACE_IFCONF

before you ./configure.

-brad

Zhang Qiang MT-CN wrote:
>
>Hello, my friends:
>  I'm trying to get Samba-2.2.1a running on my MPC823 board. I've got
>everything compiled and loaded into my target board successfully, when I
>invoke the following command:" /usr/local/samba/bin/smbclient -L WinHost",
>it print "ERROR: Could not determine network interfaces, you must use a
>interfaces config line" and exit.  I can't find the way to solve this
>problem after some tries, could someone tell me how to overcome it? The
>kernel of my target board is 2.4.4. Thanks very much.
>
>Best Regards
>
>Frank Zhang
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
