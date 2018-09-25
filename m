Return-Path: <srs0=ugol=mh=emerson.com=sachin.gosavi@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KBq15wzJzF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 17:02:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42KBq15Gn0z8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 17:02:53 +1000 (AEST)
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 42KBq11Jfwz9sB5
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2018 17:02:51 +1000 (AEST)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id D8155712DB0F
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2018 00:02:49 -0700 (MST)
Date: Tue, 25 Sep 2018 00:02:49 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1537858969882-0.post@n7.nabble.com>
In-Reply-To: <1535599586827-0.post@n7.nabble.com>
References: <1535541276673-0.post@n7.nabble.com>
 <8ca7e76b239a14e322f00cd1a0eac141472ab2bd.camel@buserror.net>
 <1535599586827-0.post@n7.nabble.com>
Subject: Re: Not able to boot cuImage for the target board with MPC8270
 processor
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I debugged the bootwrapper code by printing messages in RAM using memcpy.
The bootwrapper code appears to be executing correctly. I ensured that the
"serial_console_init" function has executed successfully. But I am still not
able to get any of the "printf" output in the wrapper code on the serial
console. 

Can anybody suggests what else I need to look at?

Thanks,
Sachin



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
