Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18098.62189.596336.471217@cargo.ozlabs.ibm.com>
Date: Fri, 3 Aug 2007 19:18:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Fix FSL BookE machine check reporting
In-Reply-To: <11860870353423-git-send-email-becky.bruce@freescale.com>
References: <11860870353423-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce writes:

> Reserved MCSR bits on FSL BookE parts may have spurious values
> when mcheck occurs.  Mask these off when printing the MCSR to
> avoid confusion.  Also, get rid of the MCSR_GL_CI bit defined
> for e500 - this bit doesn't actually have any meaning.

Is this needed for 2.6.23?

Paul.
