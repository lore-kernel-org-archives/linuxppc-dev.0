Date: Mon, 26 Apr 2004 15:24:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Williams <awilliam@nortelnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: Code Clean-Up
Message-ID: <20040426222444.GK19246@smtp.west.cox.net>
References: <20040426212220.GH19246@smtp.west.cox.net> <E380A44D523BD5118EAE0002A52CE5C40B87CB13@zcard0k8.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E380A44D523BD5118EAE0002A52CE5C40B87CB13@zcard0k8.ca.nortel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 26, 2004 at 05:48:10PM -0400, Andrew Williams wrote:

>
> No I have no specific code segment in mind.
> (perhaps kernel/time.c?)
>
> I was actually looking forward to 8260 vs 8270
> which have very similar immaps. Do we want to clutter
> the 8260_immap with conditional compiles specific to the
> 8280 series (70/75/80), or create a new immap_8270.h.

The problem you're thinking of has been addressed with the 'cpm2'
rename, as 8260, 8270, etc, etc (82xx) and 85xx are all quite similar.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
