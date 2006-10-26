Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id D6B0367F81
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 09:04:07 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
Date: Fri, 27 Oct 2006 01:03:53 +0200
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
In-Reply-To: <20061026133305.b0db54e6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610270103.53554.arnd@arndb.de>
Cc: linux-mm@kvack.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, ak@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1cnNkYXkgMjYgT2N0b2JlciAyMDA2IDA1OjMzLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Ogo+ICthc21saW5rYWdlIGxvbmcgY29tcGF0X3N5c19taWdyYXRlX3BhZ2VzKGNvbXBhdF9waWRf
dCBwaWQsCj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0X3Vsb25nX3QgbWF4bm9kZSwK
PiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb25zdCBjb21wYXRfdWxvbmdfdCBfX3VzZXIgKm9s
ZF9ub2RlcywKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb25zdCBjb21wYXRfdWxvbmdfdCBf
X3VzZXIgKm5ld19ub2RlcykKPiArewo+ICugoKCgoKCgbm9kZW1hc2tfdCBvbGQ7Cj4gK6CgoKCg
oKBub2RlbWFza190IG5ldzsKPiAroKCgoKCgoGludCBlcnI7Cj4gKwo+ICugoKCgoKCgZXJyID0g
Z2V0X25vZGVzKCZvbGQsIG9sZF9ub2RlcywgbWF4bm9kZSk7Cj4gK6CgoKCgoKBpZiAoZXJyKQo+
ICugoKCgoKCgoKCgoKCgoKByZXR1cm4gZXJyOwo+ICsKPiAroKCgoKCgoGVyciA9IGdldF9ub2Rl
cygmbmV3LCBuZXdfbm9kZXMsIG1heG5vZGUpOwoKSSBndWVzcyB5b3Ugd2FudCB0byBjYWxsIGNv
bXBhdF9nZXRfbm9kZXMsIG5vdCBnZXRfbm9kZXMgaGVyZSwKcmlnaHQ/CgoJQXJuZCA8PjwK
