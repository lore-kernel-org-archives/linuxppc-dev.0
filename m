Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.244])
	by ozlabs.org (Postfix) with ESMTP id 0CC1BDE041
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:20:31 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so205135agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:20:29 -0800 (PST)
Message-ID: <fa686aa40801090720y35dc132bsfb4921439b8f6d97@mail.gmail.com>
Date: Wed, 9 Jan 2008 08:20:29 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <4784E67F.6000000@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de>
	<fa686aa40801090644q5d1aa117ka7e8f5aed34237bd@mail.gmail.com>
	<20080109144910.GA4222@powerlinux.fr>
	<4784E67F.6000000@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Matt Sealey <matt@genesi-usa.com> wrote:
> NO.

please elaborate

>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>
> Sven Luther wrote:
> > On Wed, Jan 09, 2008 at 07:44:58AM -0700, Grant Likely wrote:
> >> Woo!  Thanks Olaf.  I was just about to sit down and write something
> >> like this myself.  Looks good to me.  I'll pick this up (but I'm going
> >> to move it to the fixup_device_tree_efika() function)
> >
> > Indeed, thanks, this makes the efika kernel again work out of the box.
> > Would it be possible to merge this upstream asap ?
> >
> > Friendly,
> >
> > Sven Luther
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
