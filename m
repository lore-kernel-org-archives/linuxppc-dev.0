Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 830B4B7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 12:44:53 +1000 (EST)
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DBF6BDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 12:44:52 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
	<4A34E4A5.3040306@redhat.com>
	<18996.60235.178618.531664@cargo.ozlabs.ibm.com>
	<4A34F564.2010500@redhat.com>
Date: Sun, 14 Jun 2009 19:44:45 -0700
In-Reply-To: <4A34F564.2010500@redhat.com> (Avi Kivity's message of "Sun, 14
	Jun 2009 16:04:36 +0300")
Message-ID: <ada4ouixlk2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 > The new Nehalems provide 8 logical threads in a single socket.  All
 > those threads share a cache, and they have cmpxchg8b anyway, so this
 > won't matter.

FWIW, Nehalem EX actually goes to 8 cores/16 threads per socket.  But
worrying about 32-bit performance on Nehalem is a little silly -- this
simplest solution is simply to run a 64-bit kernel.

 - R.
