To: m.venkatraj@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems with NFS root for ADS860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Mar 2004 22:03:18 PST."
             <301A812E6528D511A8F70008C71E578601FCF557@ap-bang-m02.india.tek.com>
Date: Thu, 11 Mar 2004 09:10:58 +0100
Message-Id: <20040311081103.D58D4C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Venkat,

in message <301A812E6528D511A8F70008C71E578601FCF557@ap-bang-m02.india.tek.com> you wrote:
>
> When the kernel tries NFS mount of the root file system, error 101 results,
> followed by a message
...
> I verified with various sources on the net that the bootargs that I was
> passing was in the correct format. Google led me to a lot of posts with the
> same problem, but no leads.. Since I am relatively new around here, looking
> up the kernel sources for the error 101 didn't lead me anywheer

Instead of seaching the web a simple local lookup would have done:

-> grep 101 /usr/include/*/errno.h
/usr/include/asm/errno.h:#define        ENETUNREACH     101     /* Network is unreachable */

"Network is unreachable". Does that ring a bell?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q: What do you get when you cross an ethernet with an income statement?
A: A local area networth.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
