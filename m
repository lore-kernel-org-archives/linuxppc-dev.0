Message-Id: <5.1.0.14.2.20030319101554.02b3c668@mail.ebshome.net>
Date: Wed, 19 Mar 2003 10:19:11 -0800
To: "Callebaut, Beno?t" <benoit.callebaut@barco.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: /drivers/mtd/mtdblock_ro.c is buggy
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <81A66F72DCACD511B0600002A551BFCB02ABC2D4@kuumex05.barco.co
 m>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:05 AM 3/19/2003, Callebaut, Benoît wrote:
>After a lot of debugging I seen that there is a bug in the MTD read only
>block driver.
>It seems that in the mtdblock_request, something goes wrong withe the
>handling of the request structure.
>between two calls to end_request, the pointer bh->req_qnext of the last used
>buffer head is corrupted.
>I didn't find the cause but since this happens only with the
>mtdblock_request function I suppose there is something wrong in it.
>
>If I ever find what's wrong I will try to correct it, but don't hope too
>much I don't have a lot of time.

I submitted fix for mtdblock_ro.c to MTD CVS several months ago.

Please, get the latest mtdblock_ro.c from
http://www.linux-mtd.infradead.org/, it should solve your problems.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
