Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040609131408.33319.qmail@web15205.mail.bjs.yahoo.com>
Date: Wed, 9 Jun 2004 21:14:08 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: How to set current time to 8xx RTC through Linux application?
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: samlinuxppc@yahoo.com.cn
In-Reply-To: <20040609130013.57180.qmail@web15204.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I added 8xx RTC driver both on U-Boot and Linux
kernel.And I could set current time right under
U-Boot.But I have no idea on making it through Linux
application?I could read it with following code but
how to set it?

#include <time.h>

     time_t t;
     struct tm * tm;

     time(&t);
     tm=localtime(&t);

     printf("\nThe corrent time is : %02d.%02d.%02d
%02d:%02d:%02d\n",tm->tm_year+1900,tm->tm_mon+1,tm->tm_mday,tm->tm_hour,tm->tm_min,tm->tm_sec);

Thanks in advance!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
