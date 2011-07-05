Return-Path: <mlcreech@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEB27B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 09:14:41 +1000 (EST)
Received: by vws20 with SMTP id 20so5074541vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 16:14:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110705180138.469f34d1@schlenkerla.am.freescale.net>
References: <20110705151525.438e87dc@schlenkerla.am.freescale.net>
	<1309905302-1990-1-git-send-email-mlcreech@gmail.com>
	<20110705180138.469f34d1@schlenkerla.am.freescale.net>
Date: Tue, 5 Jul 2011 19:14:38 -0400
Message-ID: <CAPBSBxr00GC1deSam9kSrgyju=-5VX-t+5skBVNmBXVZD4BO6g@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: eLBC NAND: remove elbc_fcm_ctrl->oob_poi
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	mhench@elutions.com, rick22@wi.rr.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2011 at 7:01 PM, Scott Wood <scottwood@freescale.com> wrote:
>
> Just noticed, full_page can come out as well.
>
> Otherwise, ACK
>

Oh right, didn't notice that - thanks.

-- 
Matthew L. Creech
