Return-Path: <iasx40@yahoo.com>
Received: from web30511.mail.mud.yahoo.com (web30511.mail.mud.yahoo.com
	[68.142.201.239]) by ozlabs.org (Postfix) with SMTP id F0AA867A07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 22:09:12 +1000 (EST)
Message-ID: <20050520120231.94106.qmail@web30511.mail.mud.yahoo.com>
Date: Fri, 20 May 2005 05:02:31 -0700 (PDT)
From: kiran kumar <iasx40@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: schedule_task
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,
  In my module I am using schedule_task()
and passing tq_struct. 'ps -xa' reports
the status of the task. When module removed from 
kernel, still 'ps -xa' reports final task is sleeping.
I called flush_scheduled_tasks(), when unloading
module. No progress. Kindly, explain how remove
process.

Thanks.
-kiran


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
