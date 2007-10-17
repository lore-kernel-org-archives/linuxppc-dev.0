Return-Path: <dmitry.torokhov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 18784DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:31:49 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so5007335pyi
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 21:31:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: current -git adbhid.c build error
Date: Wed, 17 Oct 2007 00:31:40 -0400
References: <20071016181644.GA9337@nineveh.local>
	<18197.36181.369197.363642@cargo.ozlabs.ibm.com>
In-Reply-To: <18197.36181.369197.363642@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710170031.40176.dmitry.torokhov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 17 October 2007, Paul Mackerras wrote:
> 
> It was a mis-merge between 555ddbb4, which made that change and *did*
> add the declaration of key, and 9a402b64, which deleted the line that
> the declaration of key was added to.

Oops, sorry.

> 
> We need the patch below.  Dmitry, will you push it or will I?
> 

Please do. Thanks!

-- 
Dmitry
