Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17448.25928.87568.579404@cargo.ozlabs.ibm.com>
Date: Tue, 28 Mar 2006 09:20:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Laurent MEYER <meyerlau@fr.ibm.com>
Subject: Re: [PATCH] sigaltstack bad behavior on powerpc64
In-Reply-To: <1143452261.3911.16.camel@localhost.localdomain>
References: <1143452261.3911.16.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, olh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent MEYER writes:

> I may have found a bug in powerpc64 arch specific code.

Yes, you're right, it's a bug.

> I wrote a small patch to add a condition in get_sigframe().

Looks correct.  Thanks.  I'll put it in.

Paul.
