MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Setting i2c_i2brg 
Date: Fri, 15 Feb 2002 10:24:02 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459473@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Pergola, Michael" <MichaelPergola@Danfoss.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is covered in chapter 16.13 of the reference manual for the
mpc823e,
especially in 16.13.7 "Programming the I2C Controller"
Check 16.13.7.5 where they discuss the I2BRG register.

I believe you can run it at any speed upto 115kb/s (you might even get
higher
but then it is device specific)

Hope this helps,

K.D.

> -----Original Message-----
> From: Pergola, Michael [mailto:MichaelPergola@Danfoss.com]
> Sent: 14. febrúar 2002 20:38
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Setting i2c_i2brg
>
>
>
> All,
> I am using an Embedded Planet MPC823e platform attempting to get I2C
> operational. How do you relate setting the SCL clock speed with the
> following variable i2c->i2c_i2brg ? It is currently set to 7
> but I can find
> no documentation showing what speed this runs the I2C I/F or what the
> choices for the bus would be.
>
> Regards,
>      Michael Pergola
>      Software Engineer
>      Baltimore, MD  21236     (410) 931-6778 x4259
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
