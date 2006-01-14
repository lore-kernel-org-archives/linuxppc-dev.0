Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-07.bluehost.com (outbound-mail-07.bluehost.com
	[67.138.240.207]) by ozlabs.org (Postfix) with SMTP id 0E9396893D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 20:55:08 +1100 (EST)
Message-ID: <43C8CA74.3000407@secretlab.ca>
Date: Sat, 14 Jan 2006 02:55:00 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: ML300 & ML403 patches
References: <1136795579724-git-send-email-grant.likely@secretlab.ca>
	<43C69130.2040409@ru.mvista.com>
In-Reply-To: <43C69130.2040409@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei,

After a conversation with Matt today, I've rebased my current patch 
(with typo fixes) and submitted it again to be included for 2.6.16-rc1.  
It does not have the changes that we talked about, but the changes are 
pretty low impact and can be handled as bug fixes & cleanup during the 
.16 stablization period.

Also, this give us a decent baseline to make changes from in the .17 
timeframe.

Cheers,
g.



-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
