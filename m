Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910810301215r2d09ddebtc7a94e8ed73234e@mail.gmail.com>
Date: Thu, 30 Oct 2008 15:15:09 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: warning in arch/powerpc/boot/main.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this warning a 64/32b issue?

  BOOTCC  arch/powerpc/boot/main.o
arch/powerpc/boot/main.c: In function 'prep_kernel':
arch/powerpc/boot/main.c:65: warning: format '%08x' expects type
'unsigned int', but argument 3 has type 'long unsigned int'

-- 
Jon Smirl
jonsmirl@gmail.com
