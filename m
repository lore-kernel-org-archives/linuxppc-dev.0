Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id ED9D7B7BE7
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 17:33:56 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 4so21903eyf.33
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 00:33:54 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] i2c-mpc: Do not generate STOP after read.
References: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<4ABC94ED.6070508@grandegger.com>
	<OFDA26E787.32612566-ONC125763E.007AD2FD-C125763E.007B4FFC@transmode.se>
	<20090928092809.7272b6e6@hyperion.delvare>
	<OFC822309E.F9FB4F3C-ONC125763F.0029159C-C125763F.00293F85@transmode.se>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 28 Sep 2009 09:33:50 +0200
In-Reply-To: <OFC822309E.F9FB4F3C-ONC125763F.0029159C-C125763F.00293F85@transmode.se>
	(Joakim Tjernlund's message of "Mon\,
	28 Sep 2009 09\:30\:32 +0200")
Message-ID: <87my4fseu9.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Esben Haabendal <eha@doredevelopment.dk>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Joakim" == Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

Hi,

 Joakim> Ah, that explains it. Who then will look after i2c-mpc? Kumar?

Ben Dooks (embedded i2c maintainer). He's afaik coming home today, so
give him a few days to catch up on mails.

-- 
Bye, Peter Korsgaard
