From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16065.31312.163813.582334@argo.ozlabs.ibm.com>
Date: Wed, 14 May 2003 09:05:52 +1000
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
In-Reply-To: <20030512211733.B489EC6092@atlas.denx.de>
References: <20030512211733.B489EC6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk writes:

> I would like to find out if there is some consensus about the use  of
> set_rtc_time() in the timer interrupt handler.

The consensus so far seems to be that we shouldn't call set_rtc_time
in the timer interrupt handler.  Is anyone willing to speak up with a
reason why we should keep it?  If not, we'll take it out.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
