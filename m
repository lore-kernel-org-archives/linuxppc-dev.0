Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711271946q1b600d97mf5abe71cc64bbf81@mail.gmail.com>
Date: Tue, 27 Nov 2007 22:46:16 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: of_compat_cmp on various platforms
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this right or should it be the same everywhere?

asm-powerpc/prom.h:#define of_compat_cmp(s1, s2, l)     strcasecmp((s1), (s2))
asm-sparc/prom.h:#define of_compat_cmp(s1, s2, l)       strncmp((s1), (s2), (l))
asm-sparc64/prom.h:#define of_compat_cmp(s1, s2, l)     strncmp((s1), (s2), (l))

-- 
Jon Smirl
jonsmirl@gmail.com
