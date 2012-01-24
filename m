Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 133CDB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 18:35:50 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: NTP server sync issue
Date: Tue, 24 Jan 2012 07:35:28 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE029B20@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4F01EEFE.9040305@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi ,


On my target the date time in linux is not getting updated as per
The NTP server date. The update of date  and sync between NTP server and NTP=
 client on the target happens 
Correctly when the NTP server is made up and then the ntp client is made up.
If I make the NTP server down and then make the NTP client up , then again m=
ake the NTP server up the sync between NTP server
And NTP client on my target fails. The date does not get updated. Could you=
 please look the below logs and suggest.
I see that in the not working condition the time reset gets negative value.

WORKING

# tail /var/log/messages
Jan 23 14:10:06 (none) daemon.notice ntpd[942]: time reset +412128001.43
5663 s
Jan 23 14:10:06 (none) daemon.notice ntpd[942]: kernel time sync disable
d 0041

#date // cmd on linux shell
Mon Jan 23 14:10:06 UTC 2012


NON WORKING 


# tail /var/log/messages
Jan 5 11:11:06 (none) daemon.notice ntpd[950]: time reset -844571647.34
3679 s
Jan 5 11:11:06 (none) daemon.notice ntpd[950]: kernel time sync disable
d 0041

#date // cmd on linux shell
Wed Jan 5 11:12:35 UTC 1943  


Regards,
Smitha
Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com
