From: "Calum Selkirk" <cselkirk@sophix.uklinux.net>
Date: Wed, 10 Jan 2001 11:46:26 +0000
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: /proc/sys/net/ipv4/ip_always_defrag
Message-ID: <20010110114626.I27006@sophix.uklinux.net>
References: <B6813150.8234%bootc@worldnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B6813150.8234%bootc@worldnet.fr>; from bootc@worldnet.fr on Tue, Jan 09, 2001 at 09:21:34PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Boot [bootc@worldnet.fr] wrote:

> One minor problem though, is that when I boot up (from a LinuxPPC 2000
> installation), after the "Entering non-interactive startup" message, I
> get a message stating that it could not find the file
> "/proc/sys/net/ipv4/ip_always_defrag", which it tries to set to "1" by
> echoing to it.  Can this be ignored?  Is there a way of either getting
> this proc entry back or removing the script code that echoes to it?  I
> must admit that I haven't looked at any of the files in /etc/rc.d with
> great detail...

this is controlled by /etc/sysctl.conf

HTH

calum

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
