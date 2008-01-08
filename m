Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64A0EDDF8B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:03:03 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m08J2t4H024490
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 14:02:55 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m08J2tjA113902
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 14:02:55 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m08J2twK030906
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 14:02:55 -0500
Date: Tue, 8 Jan 2008 13:02:51 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Hwmon for Taco
Message-ID: <20080108130251.7ae351c7@zod.rchland.ibm.com>
In-Reply-To: <4783C128.8050103@pikatech.com>
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
	<47831868.3030309@pikatech.com>
	<fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
	<4783C128.8050103@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 Jan 2008 13:30:00 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Ok, here is the ad7414 only. taco-dtm is no more!

Cool.  Couple more things.

1) This should go through the hwmon maintainer.  Send it to him.
(CC'ing this list is of course fine.)

2) You always need the Signed-off-by: for each patch you send

3) If you didn't author the code (this seems to come from Stefan), then
you need the Signed-off-by from the original author.

You're getting there :)  These are all "newbie" type mistakes so keep
plugging away.

josh
