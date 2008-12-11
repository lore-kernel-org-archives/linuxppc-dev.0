Return-Path: <dhowells@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id E0A41DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 01:55:01 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20081211093709.30ca04f6@zod.rchland.ibm.com>
References: <20081211093709.30ca04f6@zod.rchland.ibm.com>
	<20081211125354.20641.23213.stgit@warthog.procyon.org.uk>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] NOMMU: Rename PowerPC's struct vm_region
Date: Thu, 11 Dec 2008 14:54:57 +0000
Message-ID: <23168.1229007297@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Is there a reason you renamed all the function names as well when they
> are static?

Well, static functions can still conflict with a function of the same name
that's declared globally in a header file, but mainly because M-x
replace-string doesn't differentiate.

David
