Date: Thu, 15 May 2003 08:27:26 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE : How ?
Message-ID: <3EC71585@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Rakesh
>Hi all,
>
> Can anyone suggest me how we can invoke the interrupt generated in the
>kernel from the user application. I am getting the interrupt in the driver, I
>want to update some register in the application, when the inettrupt will be
>generated, Right now I am using polloing method. Continuously I am calling
>read routines.

>Thanks in advance,

>Rakesh Jagota

First a remark : "How" isn't a good subject title because we could answer "
So".

What do you want to do exaclty. That your driver receive interrupt from the
hardware, read datas from it and after that warn an application that something
happened ?
If the answer is yes, I can say to you that is possible and even easy. To warn
your application from your driver it is a little bit harder because normally a
driver don't do that. A driver is unaware of the applications, It only answer
to request (read/write,ioctl requests)
Please be more specific and first erad the Linux Device Driver book from O
reilly. ( available as PDF freely, search for the address on this mailing
list)

Benoit Callebaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
