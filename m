Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18462.18666.311902.814778@cargo.ozlabs.ibm.com>
Date: Mon, 5 May 2008 09:38:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to link a .o with all modules
In-Reply-To: <481E4655.7040000@zytor.com>
References: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
	<481E4655.7040000@zytor.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>, sam@ravnborg.org,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

H. Peter Anvin writes:

> Why is having them as an EXPORT_SYMBOL() counterproductive?  It sounds 
> like *exactly* what you need -- and then having the kernel provide the 
> same code to modules, instead of replication...?

It means we would go through a trampoline just to call little things
like __ucmpdi2, which seems a bit unnecessary.

Paul.
