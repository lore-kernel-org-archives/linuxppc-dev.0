Date: Fri, 12 Feb 1999 14:33:33 -0500
From: Jeff Dubrule <igor@pobox.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Uploaded imlib-1.9.2-3 RPMs
Message-ID: <19990212143332.K16578@belltower.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I uploaded my compiles of imlib-1.9.2-3, imlib-devel-1.9.2-3, and
imlib-cfgeditor-1.9.2-3 to ftp.linuxppc.org/incoming

These were compiled on a pre-R5-running MkLinux machine, and are linked
against GTK+-1.1.15

I did have to make a couple of modifications to the spec files to make them
build correctly, as the '%files' was rather bogus.

-igor

Name        : imlib                       Distribution: (none)
Version     : 1.9.2                             Vendor: (none)
Release     : 3                             Build Date: Fri Feb 12 14:17:02 1999
Install date: Fri Feb 12 14:19:18 1999      Build Host: belltower
Group       : X11/Libraries                 Source RPM: imlib-1.9.2-3.src.rpm
Size        : 490821                           License: LGPL
Packager    : The Rasterman <raster@redhat.com>
URL         : http://www.labs.redhat.com/imlib
Summary     : Image loading and rendering library for X11R6
Description :
Imlib is an advanced replacement library for libraries like libXpm that
provides many more features with much greater flexability and
speed.

Name        : imlib-devel                 Distribution: (none)
Version     : 1.9.2                             Vendor: (none)
Release     : 3                             Build Date: Fri Feb 12 14:17:02 1999
Install date: Fri Feb 12 14:20:23 1999      Build Host: belltower
Group       : X11/Libraries                 Source RPM: imlib-1.9.2-3.src.rpm
Size        : 625196                           License: LGPL
Packager    : The Rasterman <raster@redhat.com>
URL         : http://www.labs.redhat.com/imlib
Summary     : Imlib headers, static libraries and documentation
Description :
Headers, static libraries and documentation for Imlib.

Name        : imlib-cfgeditor             Distribution: (none)
Version     : 1.9.2                             Vendor: (none)
Release     : 3                             Build Date: Fri Feb 12 14:17:02 1999
Install date: Fri Feb 12 14:20:19 1999      Build Host: belltower
Group       : X11/Libraries                 Source RPM: imlib-1.9.2-3.src.rpm
Size        : 362875                           License: LGPL
Packager    : The Rasterman <raster@redhat.com>
URL         : http://www.labs.redhat.com/imlib
Summary     : Imlib configuration editor
Description :
The imlib_config program allows you to control the way imlib uses
color and handles gamma correction/etc.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
