From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 14 Mar 2003 10:52:54 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030314175254.GA9081@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com> <20030313223853.GA6921@rover.farnsworth.org> <20030314114317.GB26518@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030314114317.GB26518@iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 11:43:17AM +0000, Gabriel Paubert wrote:
> On Thu, Mar 13, 2003 at 03:38:53PM -0700, Dale Farnsworth wrote:
> > -	li	r9,0x0000
> > +	li	r9,0x000c
> >  	mtlr	r9
> >  	blr
>
> Why not "ba 0x000c" instead? Just saves 8 bytes cheaply.
>
> 	Gabriel

Looks good to me.
I didn't consider it because I've never seen ba before. :-)

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
