Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain; charset="iso-8859-1"
From: Gerard Flynn <flynn@lure.u-psud.fr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: TQM8xx modules
Date: Tue, 11 Dec 2001 16:56:23 +0100
MIME-Version: 1.0
Message-ID: <E16DpGa-0004k0-00@tamesis.lure.u-psud.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Is anyone using the linux-ppc kernel tree for TQM minimodules ?

  I tried to compile the development branch for the TQM855L but the zImage
build fails because no embed_config function is defined for this
configuration.

  If anyone has a pointer to the simplest way to get a kernel running on this
type of module I'd greatly appreciate it.  (I know Denx has a patch for these
modules for a 2.2 kernel but the kernel against which it was made appears no
longer to be available.)

  Thanks,
  Gerard Flynn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
