Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id CC2391A013F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 18:56:04 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20994-02 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 15 Jul 2014 09:55:53 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Bernat' <vincent@bernat.im>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] ppc/xmon: use isxdigit/isspace/isalnum from ctype.h
Date: Tue, 15 Jul 2014 08:55:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17272643@AcuExch.aculab.com>
References: <1405409302-5299-1-git-send-email-vincent@bernat.im>
In-Reply-To: <1405409302-5299-1-git-send-email-vincent@bernat.im>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogVmluY2VudCBCZXJuYXQNCj4gVXNlIGxpbnV4L2N0eXBlLmggaW5zdGVhZCBvZiBkZWZp
bmluZyBjdXN0b20gdmVyc2lvbnMgb2YNCj4gaXN4ZGlnaXQvaXNzcGFjZS9pc2FsbnVtLg0KDQou
Li4NCj4gLSNkZWZpbmUgaXNzcGFjZShjKQkoYyA9PSAnICcgfHwgYyA9PSAnXHQnIHx8IGMgPT0g
MTAgfHwgYyA9PSAxMyB8fCBjID09IDApDQoNClRoYXQgaXMgZGlmZmVyZW50IGZyb20gdGhlIHZl
cnNpb24gaW4gbGludXgvY3R5cGUuaA0KRXNwZWNpYWxseSBmb3IgJ2MgPT0gMCcsIGJ1dCBwcm9i
YWJseSBhbHNvIHZlcnRpY2FsIHRhYiBhbmQgZm9ybSBmZWVkLg0KDQoJRGF2aWQNCg0K
