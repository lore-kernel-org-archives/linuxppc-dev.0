Message-ID: <20020711224210.62434.qmail@web11505.mail.yahoo.com>
Date: Thu, 11 Jul 2002 15:42:10 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: tasklets and waking up sleeping process question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have new to Linux. I am reading the Linux device
driver book second eddition and am trying to make some
sense out of it.

I am trying to implement an interrupt handler. From
the description in the book, it seems that one can go
about implementing the bottom half either using the
tasklets method or by waking up a sleeping process in
the top half interrupt handler.

Is what I understood correct or I am totally of the
topics?

When do you determine which method to implement for an
interrupt handler?

Regards,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
