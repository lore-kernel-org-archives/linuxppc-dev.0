Return-Path: <joro-2013@t-online.de>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A778A1A021A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 03:32:27 +1100 (EST)
Received: from fwd40.aul.t-online.de (fwd40.aul.t-online.de [172.20.26.139])
 by mailout11.t-online.de (Postfix) with SMTP id CCF524C9902
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 18:23:23 +0200 (CEST)
Message-ID: <543AAADB.1070304@t-online.de>
Date: Sun, 12 Oct 2014 18:22:51 +0200
From: Jochen Rollwagen <joro-2013@t-online.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc32: add support for csum_add()
Content-Type: multipart/alternative;
 boundary="------------090602020601000902080309"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090602020601000902080309
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html

only compiles after putting an #ifndef ARCH_HAS_CSUM_ADD around the 
definition in include/net/checksum.h

This is missing from the patch

--------------090602020601000902080309
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    This patch<br>
    <br>
    <span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black"><a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html">https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121144.html</a><br>
      <br>
      only compiles after putting an #ifndef ARCH_HAS_CSUM_ADD around
      the definition in include/net/checksum.h<br>
      <br>
      This is missing from the patch<br>
    </span>
  </body>
</html>

--------------090602020601000902080309--
