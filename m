From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 14 May 2003 17:43:10 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030514154310.GC9430@iram.es>
References: <20030512211733.B489EC6092@atlas.denx.de> <16065.31312.163813.582334@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16065.31312.163813.582334@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 14, 2003 at 09:05:52AM +1000, Paul Mackerras wrote:
>
> Wolfgang Denk writes:
>
> > I would like to find out if there is some consensus about the use  of
> > set_rtc_time() in the timer interrupt handler.
>
> The consensus so far seems to be that we shouldn't call set_rtc_time
> in the timer interrupt handler.  Is anyone willing to speak up with a
> reason why we should keep it?  If not, we'll take it out.

Ask on the ntp lists first, I bet you'll upset a lot of people
if you suggest it.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
