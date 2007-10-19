Return-Path: <alan@akb.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id 746F8DDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 00:29:46 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so442004wri
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 07:29:44 -0700 (PDT)
Message-ID: <bfa0697f0710190729r64ad503foabdb20f446310520@mail.gmail.com>
Date: Fri, 19 Oct 2007 08:29:43 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: mahendravarman15@gmail.com, linuxppc-dev@ozlabs.org
Subject: re: Linux root file system with X window support for a powerpc board
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

debian:
(on x86/fedora development system) (used on 82xx)
  1. debootstrap with the --foreign
    i.e. debootstrap --arch powerpc etch http://mirrors.kernel.org/debian
    mannually create an inittab, create/copy some default /dev entries

  2. boot 74xx target with above root filesystem, run
/debootstrap/debootstrap --second-stage
  Now add in packages using apt-get (or add them initially in step 1)

-Alan


Hi all

Can anybody help me how to create a Linux root file system with X
window support for a powerpc 74xx based board ?

Any documents/links  related to that is also welcome

Thanks in advance

R.Mahendravarman
