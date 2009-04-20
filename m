Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97588DE04E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 08:34:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18924.63578.495727.152443@cargo.ozlabs.ibm.com>
Date: Tue, 21 Apr 2009 08:34:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
In-Reply-To: <20090420225659.7b92a184@hyperion.delvare>
References: <20090420225659.7b92a184@hyperion.delvare>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare writes:

> Takashi, please push this patch to Linus quickly, as this is blocking
> the removal of the legacy i2c binding model, which is scheduled for
> 2.6.30.

I really don't think you can remove it from Linus' tree at this stage
in the 2.6.30 cycle.  If it was going to be removed it should have
been removed in the merge window.  Removing it now has too much risk
of introducing regressions in my opinion.

I presume you have a development tree where you queue up commits for
the i2c subsystem for the next merge window.  I suggest you do the
removal there now (or whenever you like) and push it to Linus in the
next merge window.

Paul.
