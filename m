Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14797DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 12:59:09 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5N2x3qN019241
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 22:59:03 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5N2x30S175442
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 22:59:03 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5N2x3Eq026788
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 22:59:03 -0400
Message-ID: <485F116E.6010505@austin.ibm.com>
Date: Sun, 22 Jun 2008 21:58:54 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/5] Allow drc indexes to be specified in formats other
	than	decimal
References: <485C2033.20101@austin.ibm.com> <485C2134.4030109@austin.ibm.com>
	<485C3ABF.7030008@ru.mvista.com>
In-Reply-To: <485C3ABF.7030008@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
>   I guess checkpatch.pl told you to consider switching to 
> strict_strtol()? :-)
> 
> WBR, Sergei
> 

Yes, it did warn about not switching.  There other places in this file
that use simple_strtoul so I was hoping to submit a followon patch that
converts everything.

-Nathan
