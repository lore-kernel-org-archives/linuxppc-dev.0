Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17727.55399.959132.886705@cargo.ozlabs.ibm.com>
Date: Thu, 26 Oct 2006 07:34:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <20061025092210.6d208031@localhost.localdomain>
References: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
	<20061025092210.6d208031@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> On Wed, 25 Oct 2006 16:26:13 +1000 Paul Mackerras <paulus@samba.org> wrote:
> 
> > Jake Moilanen:
> >       [POWERPC] Add 970GX cputable entry
> 
> I didn't see them fix the head_64.S issue with this patch.

There was no "issue", there was a possible further optimization, but
that's not a reason not to put in the cputable entry in the first
place.

Paul.
