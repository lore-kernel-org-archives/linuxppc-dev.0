Return-Path: <oakad@yahoo.com>
Received: from web37603.mail.mud.yahoo.com (web37603.mail.mud.yahoo.com
	[209.191.87.86]) by ozlabs.org (Postfix) with SMTP id C7D32B7CBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 12:34:21 +1100 (EST)
Message-ID: <26163.54141.qm@web37603.mail.mud.yahoo.com>
Date: Tue, 19 Jan 2010 17:34:19 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Large physical address support on e500 platform
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <DC402F23-C6B5-4F7E-B66D-F0AFCC298CEA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> =0A> > So, the obvious question is, what is the current=0A> status of lar=
ge physical=0A> > address support on e500? Is it a problem in current=0A> g=
it version or is it=0A> > not ready yet?=0A> > =0A> > Thanks.=0A> =0A> Its =
possible that we've broken module/vmalloc support with=0A> "Large physical =
addressing".=A0 Its not something I've=0A> tried in a while.=A0 What kernel=
/git SHA are you using.=0A> =0A=0AI'm just pulling in from the main kernel =
tree git.=0AMy current version is 2.6.33-rc4-00193-gd1e4922-dirty,=0Abut it=
 had not changed since 2.6.33-rc2=0A=0AI started from 2.6.32, but I don't r=
emember if I had a large PA=0Asupport enabled there.=0A=0A=0A=0A=0A      __=
___________________________________________________________________________=
_____=0ASee what's on at the movies in your area. Find out now: http://au.m=
ovies.yahoo.com/session-times/
