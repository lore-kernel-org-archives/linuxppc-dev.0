Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id C98BC679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 14:04:29 +1000 (EST)
Message-ID: <44D2C746.70303@dlasys.net>
Date: Fri, 04 Aug 2006 00:04:22 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: MTD Flash Howto ?
Content-Type: multipart/alternative;
	boundary="------------060809090406080104030508"
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060809090406080104030508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


    I need to put together a filesystem driver for the flash in the Pico
E-12.
    I think I have a pretty good grasp of what I need of the FileSystem
end of things.

    But I am less certain of the peices needed to get from the flash to
the block driver that I assume underly's the FileSystem.
    I have enabled MTD, and configured a starting address and size.
    I got a signon banner. How can I tell if it has really found my
flash and if it actually knows the type of flash it found - in my
    instance Spansion S29GL512N.

    I have found some documentation covering details, I think I am more
interested in something that gives a more zoomed out view.

    Is anyone aware of a relevant howto ? Maybe some web pages on the
end-end process of going from flash devices to filesystems over flash ?

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------060809090406080104030508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial"><br>
&nbsp;&nbsp;&nbsp; I need to put together a filesystem driver for the flash in the
Pico E-12.<br>
&nbsp;&nbsp;&nbsp; I think I have a pretty good grasp of what I need of the FileSystem
end of things.<br>
<br>
&nbsp;&nbsp;&nbsp; But I am less certain of the peices needed to get from the flash to
the block driver that I assume underly's the FileSystem.<br>
&nbsp;&nbsp;&nbsp; I have enabled MTD, and configured a starting address and size.<br>
&nbsp;&nbsp;&nbsp; I got a signon banner. How can I tell if it has really found my
flash and if it actually knows the type of flash it found - in my <br>
&nbsp;&nbsp;&nbsp; instance Spansion S29GL512N.<br>
<br>
&nbsp;&nbsp;&nbsp; I have found some documentation covering details, I think I am more
interested in something that gives a more zoomed out view.<br>
<br>
&nbsp;&nbsp;&nbsp; Is anyone aware of a relevant howto ? Maybe some web pages on the
end-end process of going from flash devices to filesystems over flash ?<br>
<br>
</font>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated"
 href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a
 class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------060809090406080104030508--
