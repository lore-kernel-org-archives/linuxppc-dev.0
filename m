Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 61C19DDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:50:15 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so57443anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 06:50:14 -0800 (PST)
Message-ID: <fa686aa40801090650l38bea6a0l7a1ea2d81667f42e@mail.gmail.com>
Date: Wed, 9 Jan 2008 07:50:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sven Luther" <sven@powerlinux.fr>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <20080109144910.GA4222@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de>
	<fa686aa40801090644q5d1aa117ka7e8f5aed34237bd@mail.gmail.com>
	<20080109144910.GA4222@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Sven Luther <sven@powerlinux.fr> wrote:
> On Wed, Jan 09, 2008 at 07:44:58AM -0700, Grant Likely wrote:
> > Woo!  Thanks Olaf.  I was just about to sit down and write something
> > like this myself.  Looks good to me.  I'll pick this up (but I'm going
> > to move it to the fixup_device_tree_efika() function)
>
> Indeed, thanks, this makes the efika kernel again work out of the box.
> Would it be possible to merge this upstream asap ?

I'll see if paulus will pick it up for 2.6.24

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
