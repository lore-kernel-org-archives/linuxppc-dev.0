Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id CEBFBDDE40
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 18:39:18 +1000 (EST)
Message-ID: <47186D35.9070800@anagramm.de>
Date: Fri, 19 Oct 2007 10:39:17 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: pjmaiya <pjmaiya@signal-networks.com>
Subject: Re: tiny login: useradd command
References: <005e01c81171$11421820$4601a8c0@signet>
In-Reply-To: <005e01c81171$11421820$4601a8c0@signet>
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

pjmaiya schrieb:
 > Hi,
 >  I am using montavista linux.

Then, please ask their support, when they charge a 5 number USD amount as
part of their license/support model. (That's what I've been told this week.)

 > Using TCT tool i have added package for
 > user creation. I am having following problem
 >
 >     * If I use tiny login package, I will be getting useradd binary but
 >       number of parameter are few like
 >
 >  Usage: adduser [OPTIONS]... <USER>
 >
 > Options:
 >
 >   -h <directory>    specify home directory
 >   -s <shell>        specify shell
 >   -g <gecos>        specify GECOS string
 >
 >     * If I don't use tiny login package, I will be selecting useradd
 >       package from admin menu. But I am unable to execute this command
 >       since it gives follwing error
 >
 >       /usr/sbin/groupadd missing..
 >
 >
 >     * Actually I want useradd command similar to linux where more
 >       argument are taken, especially I wanted 'user' to be part of more
 >       than one group.
 >
 > can anyone help me out..

I would just take useradd/groupadd from the Shadow password file utilities.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
