Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FA28DDE3E
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 03:37:57 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NGbZI5007366
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 11:37:35 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NGbrQm056988
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 09:37:53 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NGbrKa003919
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 09:37:53 -0700
Date: Sat, 23 Feb 2008 10:37:23 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <erick205@umn.edu>
Subject: Re: [PATCH] [POWERPC] 40X: Add Default Restart Machdep Method to
	40X Platforms
Message-ID: <20080223103723.792efc75@zod.rchland.ibm.com>
In-Reply-To: <C3E49AAC.D8E4%erick205@umn.edu>
References: <C3E49AAC.D8E4%erick205@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 15:28:44 -0800
Grant Erickson <erick205@umn.edu> wrote:

> This patch restores the reset on restart functionality to 40x-based
> platforms that was formerly provided--but not used in arch/powerpc--by
> abort() in head_40x.S. This functionality is now provided by
> ppc40x_reset_system(char *) in a fashion similar to that of the 44x-based
> platforms.
> 
> Compiled, linked and tested against the AMCC Haleakala board.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

This patch is word wrapped.  Seems your mailer decided to eat tabs as
well.

josh
