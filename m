Return-Path: <iluri@fagorautomation.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id 8D7F768809
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 20:28:20 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id 5C2061B77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 10:28:18 +0100 (CET)
Message-ID: <43858855.8080304@fagorautomation.es>
Date: Thu, 24 Nov 2005 10:31:01 +0100
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@ozlabs.org
References: <000901c5f03c$5d4e8c60$6405a8c0@absolut><4384921A.8010901@fagora
	utomation.es> <200511240925.21942.david.jander@protonic.nl>
In-Reply-To: <200511240925.21942.david.jander@protonic.nl>
Content-Type: text/plain;
	charset=UTF-8;
	format=flowed
Subject: Re: USB Keyboard Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:

>>root=/dev/nfs rw ip=on console=tty console=ttyS0 init=/sbin/init
>>    
>>
>
>I suppose putting two "console=" statements on the commandline doesn't do much 
>more than just removing the first one.
>
>Greetings,
>
>  
>
Dear David,

the first console argument defines where is stdout and the second 
console argument defines where is the stdout and stdin. With this 
configuration you can duplicate stdout, you can see the output on two 
devices, screen and serial line.


Bye.
