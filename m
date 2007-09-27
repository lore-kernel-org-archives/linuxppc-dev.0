Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 60C32DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 06:03:15 +1000 (EST)
Date: Thu, 27 Sep 2007 12:10:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: ljd015@freescale.com
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
Message-ID: <20070927191036.GD7838@mag.az.mvista.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11909173512321-git-send-email-ljd015@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 02:22:31PM -0400, ljd015@freescale.com wrote:
> From: Joe D'Abbraccio <ljd015@freescale.com>
> 
> The MPC837x RDB is a new member of the Freescale MPC83xx reference design
> boards.

FYI, if you have patches for arch/powerpc, I recommend that you submit
them to linuxppc-dev.  linuxppc-embedded is not monitored by many
important people including paulus.

Since these are 8xxx patches, chances are Kumar will see them and take
them but you're still better off submitting to linuxppc-dev.

Mark
