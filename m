Date: Mon, 26 Apr 2004 14:22:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Williams <awilliam@nortelnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: Code Clean-Up
Message-ID: <20040426212220.GH19246@smtp.west.cox.net>
References: <E380A44D523BD5118EAE0002A52CE5C40B87C888@zcard0k8.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E380A44D523BD5118EAE0002A52CE5C40B87C888@zcard0k8.ca.nortel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 26, 2004 at 02:50:24PM -0400, Andrew Williams wrote:

> What's the current view/policy on code cleanup?
> Eg. immap_8260.h vs 8xx_immap.h
>
>   Furthermore each unit that accesses the immap, has to conditionaly select
> the target platform header file.
>
> I'm proposing a single immap.h file, that conditionaly selects either
> immap_8260.h, or 8xx_immap.h (possibly renamed to immap_8xx.h).
>
>   Do people want to see this type of restructure/patch?

Do you have code which works on both 82xx (or looking at 'newer' code in
2.4, soon to be in 2.6, 'cpm2' which is 82xx/85xx) and 8xx ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
