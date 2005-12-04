Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17298.21156.146667.605956@cargo.ozlabs.ibm.com>
Date: Sun, 4 Dec 2005 13:21:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20051203212402.GA2821@gate.ebshome.net>
References: <11336368261610-git-send-email-otavio@debian.org>
	<20051203212402.GA2821@gate.ebshome.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Otavio Salvador <otavio@debian.org>
Subject: Re: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
	function.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin writes:

> "__init" should be placed between closing brace and semicolon. For 
> more info, see include/linux/init.h

Actually, there's no point putting __init in an extern declaration.

Paul.
