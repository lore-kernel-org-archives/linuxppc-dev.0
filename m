From: Paul Mackerras <paulus@linuxcare.com>
To: Clint Hepner <chepner@cs.dartmouth.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: TCP stalls and VJ compression
Date: Fri, 11 Feb 2000 15:51:22 +1100
Content-Type: text/plain
References: <20000210211623.B896@cs.dartmouth.edu>
MIME-Version: 1.0
Message-Id: <0002111552340D.12760@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 11 Feb 2000, Clint Hepner wrote:

> I've been having problems with stalled downloads, mainly in Netscape,
> for several weeks now. Also, I've been unable to rsync from linuxcare;
> rsync would stop once I saw the "receiving file list..." message.
> I was searching through the archives tonight, and found the recommendation to
> disable Van Jacobsen header compression on the PPP link. I wasn't sure this
> would work, though, since I'm not actually running PPP on my machine; I
> connect over Ethernet through a Mac running IPNetRouter for a PPP dialup.
> However, disabling header compressoin solved both of my problems: Netscape
> downloads without stalling, and I can rsync from linuxcare again.

Where exactly and how did you disable TCP header compression?  And what's
at the other end of your PPP link?

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
