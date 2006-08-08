Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.10198.280651.681221@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 15:57:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] powerpc: fix udbg warning
In-Reply-To: <44D68EAE.5010308@am.sony.com>
References: <44D655BF.3080803@am.sony.com>
	<44D68EAE.5010308@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> Here's an updated version that fixes a few more warnings.

I get:

fatal: corrupt patch at line 12
* Patch failed.

from git-applymbox when I try to apply it.  It looks like your mailer
turns lines that contain only whitespace into empty lines.  Please fix
it or use a different mailer.

Paul.
