Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B191B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 17:37:41 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EE5DDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 17:37:40 +1000 (EST)
Date: Fri, 21 Aug 2009 00:37:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Bugme-new] [Bug 14021] New: hfsplus caused data loss
Message-Id: <20090821003711.6a32b6e5.akpm@linux-foundation.org>
In-Reply-To: <1250839741.17238.4.camel@pasglop>
References: <bug-14021-10286@http.bugzilla.kernel.org/>
	<20090820150242.a4b5eccc.akpm@linux-foundation.org>
	<1250839741.17238.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: bugzilla-daemon@bugzilla.kernel.org, rbrito@ime.usp.br,
	linuxppc-dev@ozlabs.org, bugme-daemon@bugzilla.kernel.org,
	linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Aug 2009 17:29:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2009-08-20 at 15:02 -0700, Andrew Morton wrote:
> > (switched to email.  Please respond via emailed reply-to-all, not via the
> > bugzilla web interface).
> 
> Is Roman Zippel still around ? (I added him to the CC list). AFAIK, He
> maintains HFS and HFS+ (and was the last one to do any major work on
> them).

I don't think I've heard from Roman since January of this year.
