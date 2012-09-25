Return-Path: <teodori.serge@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84E8A2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 22:27:24 +1000 (EST)
Received: by wiwc10 with SMTP id c10so2347052wiw.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 05:27:20 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 25 Sep 2012 14:27:18 +0200
Message-ID: <CANUt7sogbn9ujj3rJHEgYwqEyWzYmEQtCDxOdCJH3yu8spdpxQ@mail.gmail.com>
Subject: /dev/port under powerpc
From: Serge Teodori <teodori.serge@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=20cf302079f4bc7b0904ca85d33e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf302079f4bc7b0904ca85d33e
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I am curently doing some cleanup, and noticed 'arch_has_dev_port()' could
be omitted if 'arch/powerpc/configs/*' would be update with
'CONFIG_DEVPORT'. My question is, which ones have or have not an 'isa pci
bridge'.

--20cf302079f4bc7b0904ca85d33e
Content-Type: text/html; charset=ISO-8859-1

<p>Hello,<br>
I am curently doing some cleanup, and noticed &#39;arch_has_dev_port()&#39; could be omitted if &#39;arch/powerpc/configs/*&#39; would be update with &#39;CONFIG_DEVPORT&#39;. My question is, which ones have or have not an &#39;isa pci bridge&#39;.</p>


--20cf302079f4bc7b0904ca85d33e--
